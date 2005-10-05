Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVJETlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVJETlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbVJETlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:41:17 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:64830 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030342AbVJETlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=R0pq/qWyujD+xAtVzO+9u8tAFtM1q6jI5IdvS4uuVKzuiZY9dYzjdpL4kUGXxB/RO+IOjgm4PkwG8TznWtWjOVG/a5Qor3wk+BAUvSHlaPUkiVbjuPeyPO0mIBDMpcL/l2a+9AYiiqYt2e9Y4vD91jc/srFzMjuX6W79Up/UoQo=
Date: Wed, 5 Oct 2005 15:37:27 -0400
From: Florin Malita <fmalita@gmail.com>
To: Marc Perkel <marc@perkel.com>
Cc: lsorense@csclub.uwaterloo.ca, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-Id: <20051005153727.994c4709.fmalita@gmail.com>
In-Reply-To: <4343E7AC.6000607@perkel.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it>
	<4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz>
	<87k6gsjalu.fsf@amaterasu.srvr.nix>
	<4343E611.1000901@perkel.com>
	<20051005144441.GC8011@csclub.uwaterloo.ca>
	<4343E7AC.6000607@perkel.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2005 07:48:12 -0700
Marc Perkel <marc@perkel.com> wrote:
> What is incredibly idiotic is a file system that allws you to delete 
> files that you have no write access to. That is stupid beyond belief and 
> only the Unix community doesn't get it.

It stops being idiotic as soon as you realize that _deleting_ a
file doesn't involve _writing_ to it in any way. It's not about UNIX,
it's about common sense - try thinking outside of the Netware box for a
sec ;)

Florin
