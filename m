Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUGRHW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUGRHW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 03:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUGRHW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 03:22:27 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48812 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263001AbUGRHW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 03:22:26 -0400
Message-ID: <40FA2535.4040207@namesys.com>
Date: Sun, 18 Jul 2004 00:22:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
CC: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com> <40F02963.5040500@namesys.com> <20040710174432.GA18719@infradead.org> <40F02E05.8090401@namesys.com> <4d8e3fd304071203204c51f6c4@mail.gmail.com>
In-Reply-To: <4d8e3fd304071203204c51f6c4@mail.gmail.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:

>
> I don't unserstand why
>the linux kernel release process can't be supported by a suite of test
>that has to be passed before being released a new -rc or final
>version.
>
>It seems there are now the all the tools we need but we are note using
>them to manage the releases.
>
>I'm referring to LTP, compile stats and regression test from OSDL.
>
>
>Ciao,
>               Paolo
>
>  
>
I agree with you wholeheartedly, and Namesys does in fact run FS related 
regression tests before sending its changes in. I wish others would do 
the same for their changes.
