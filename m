Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWEaIU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWEaIU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEaIU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:20:28 -0400
Received: from mail.artecdesign.ee ([62.65.32.9]:46522 "EHLO
	postikukk.artecdesign.ee") by vger.kernel.org with ESMTP
	id S964860AbWEaIU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:20:28 -0400
Message-ID: <447D51C8.8040503@artecdesign.ee>
Date: Wed, 31 May 2006 11:20:24 +0300
From: Indrek Kruusa <indrek.kruusa@artecdesign.ee>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: long/heavy USB fs operations panics 2.6.16.18
References: <447495CC.7040205@artecdesign.ee> <20060524192503.GJ17964@cosmic.amd.com> <447B244A.6010008@artecdesign.ee> <20060530031037.GA11543@cosmic.amd.com>
In-Reply-To: <20060530031037.GA11543@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ADG-Spam-Score: -2.6 (--)
X-ADG-Spam-ScoreInt: -25
X-ADG-Spam-Report: Content analysis details:   (-2.6 points, 5.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
X-ADG-ExiScan-Signature: 8c644d10b7d0a9bad7b479b763bfc43a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
> On 29/05/06 19:41 +0300, Indrek Kruusa wrote:
>   
>> Duh... I have to doublecheck it but currently it seems that our BIOS 
>> needs a fix. I hope you haven't had much trouble with my problem report. 
>> I much appreciate your feedback.
>>     
>
> Well, let us know if the problem persists.  Good luck.
>   

I am not able to describe it in depth but there was "layout" or 
"placement" changes needed in our mini-version BIOS (so they said). I 
just figured out that with full-blown BIOS there wasn't problems. By now 
the "mini" BIOS is also OK (especially for Linux).

Indrek

