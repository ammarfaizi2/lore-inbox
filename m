Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVLAMqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVLAMqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLAMqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:46:23 -0500
Received: from networks.syneticon.net ([213.239.212.131]:33729 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S932194AbVLAMqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:46:23 -0500
Message-ID: <438EF097.7040009@wpkg.org>
Date: Thu, 01 Dec 2005 13:46:15 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loadavg always equal or above 1.00 - how to explain?
References: <438EE515.1080001@wpkg.org> <1133440101.1615.14.camel@capoeira>
In-Reply-To: <1133440101.1615.14.camel@capoeira>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel schrieb:
> On Thu, 2005-12-01 at 12:57, Tomasz Chmielewski wrote:
> 
>>I noticed one of my Samba + OpenLDAP servers, running 2.6.11.4 kernel 
>>has loadavg always equal or above 1.00, although I can't explain it.
> 
> [...]
> 
>>What can cause this anormal load, and how can I spot it?
> 
> 
> Some hidden rootkit ?

highly unlikely, this machine is totally separated from the outer world, 
to break into it someone would have to break into several other servers 
first (and no problems with those).


-- 
Tomek
http://wpkg.org
WPKG - software deployment and upgrades with Samba
