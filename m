Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVAHAv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVAHAv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVAHAv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:51:27 -0500
Received: from main.gmane.org ([80.91.229.2]:45796 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261724AbVAHAv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:51:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicolas Michaux <nicolas-kernel@michaux.homelinux.org>
Subject: Re: [oops] # rmmod =?utf-8?b?c25kX25tMjU2?=
Date: Sat, 8 Jan 2005 00:42:23 +0000 (UTC)
Message-ID: <loom.20050108T013858-235@post.gmane.org>
References: <200412300059.42982.pluto@pld-linux.org> <s5h1xd7zrx3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.235.120.138 (Mozilla/5.0 (compatible; Konqueror/3.3; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai <at> suse.de> writes: 
>  
> At Thu, 30 Dec 2004 00:59:42 +0100, 
> Paweł Sikora wrote: 
> >  
> > # rmmod snd_nm256 
> > Oops: 0000 [#1] 
>  
> Does the patch below fix the problem? 
>  
> Takashi 
>  
 
I had same problem here and your patch fixed the problem... 
 
Many thanks, 
 
Nicolas 

