Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266780AbUGLKUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUGLKUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUGLKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:20:55 -0400
Received: from mproxy.gmail.com ([216.239.56.246]:44214 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266780AbUGLKUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:20:54 -0400
Message-ID: <4d8e3fd304071203204c51f6c4@mail.gmail.com>
Date: Mon, 12 Jul 2004 12:20:53 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Ext3 File System "Too many files" with snort
Cc: Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       jmerkey@comcast.net, Pete Harlan <harlan@artselect.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40F02E05.8090401@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com> <40F02963.5040500@namesys.com> <20040710174432.GA18719@infradead.org> <40F02E05.8090401@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004 10:57:25 -0700, Hans Reiser <reiser@namesys.com> wrote:
> Christoph Hellwig wrote:
[...]
> Lindows does it right.

I dunno how Lindows manage the release process,
but as I already wrote in a different thread, I don't unserstand why
the linux kernel release process can't be supported by a suite of test
that has to be passed before being released a new -rc or final
version.

It seems there are now the all the tools we need but we are note using
them to manage the releases.

I'm referring to LTP, compile stats and regression test from OSDL.


Ciao,
               Paolo

-- 
paoloc.doesntexist.org
