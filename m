Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSAXI5v>; Thu, 24 Jan 2002 03:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSAXI5k>; Thu, 24 Jan 2002 03:57:40 -0500
Received: from pint.pi.informatik.tu-darmstadt.de ([130.83.7.27]:14597 "EHLO
	walker.lahn.de") by vger.kernel.org with ESMTP id <S285369AbSAXI52>;
	Thu, 24 Jan 2002 03:57:28 -0500
Date: Thu, 24 Jan 2002 09:56:49 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre7
Message-ID: <20020124085649.GA30219@titan.lahn.de>
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.27i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Jan 23, 2002 at 07:55:46PM -0200, Marcelo Tosatti wrote:
> pre7:
> - Netfilter update 				(Netfilter team)
net/ipv4/netfilter/ipt_{ah,esp,ULOG}.c are missing in the patch!
Fails on install.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
