Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTI1O1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 10:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTI1O1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 10:27:52 -0400
Received: from cpc3-hitc2-5-0-cust152.lutn.cable.ntl.com ([81.99.82.152]:10988
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S262573AbTI1O1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 10:27:51 -0400
Message-ID: <3F76F1D5.3000207@reactivated.net>
Date: Sun, 28 Sep 2003 15:36:05 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030905 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound bug ?!
References: <3F76E927.7030809@mscc.huji.ac.il>
In-Reply-To: <3F76E927.7030809@mscc.huji.ac.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voicu Liviu wrote:
> Sound bug ?!
> I also have seen that this 2.6-test6 is missing a few sound cards(like 
> Ensoniq ES1371) so I was forced to use alsa!
> 

Enable "Gameport support" and you will be able to compile in support for those cards as normal.

Daniel

