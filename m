Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVGFAwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGFAwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVGFAwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:52:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbVGFAwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:52:25 -0400
Date: Tue, 5 Jul 2005 17:51:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grant Coady <grant_lkml@dodo.com.au>
cc: Jens Axboe <axboe@suse.de>, Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
In-Reply-To: <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
Message-ID: <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>
 <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org>
 <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org>
 <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org>
 <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org>
 <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Grant Coady wrote:
> 
> Executive Summary

Btw, can you try this same thing (or at least a subset) with a large file
on a filesystem? Does that show the same pattern, or is it always just the 
raw device?

		Linus
