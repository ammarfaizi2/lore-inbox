Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTJZVuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbTJZVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 16:50:04 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33800 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262592AbTJZVuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 16:50:00 -0500
Date: Sun, 26 Oct 2003 22:49:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?B?Suly6W15IEhFUlZFIChqZGgp?= <jeremy.herve@tiscali.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compilation options
Message-ID: <20031026214958.GA959@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?B?Suly6W15IEhFUlZFIChqZGgp?= <jeremy.herve@tiscali.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3F9C4BC6.2060807@tiscali.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F9C4BC6.2060807@tiscali.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 11:33:42PM +0100, "Jérémy HERVE (jdh)" wrote:
> [usually french speaker]
> 
> Hello !
> I do not really know if that is the good place to post that question, 
> but I am unable to find any answer in the FAQ.
> I would like to know if an official list of kernel compilation options 
> exists, and if it is not the case, to know how could I make it.

I assume you need this to build a module outside the kernel tree.
Follow the recommendations in Documentation/kbuild/modules.txt
This is the best we have so far.

	Sam
