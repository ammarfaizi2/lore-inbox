Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRKRLBI>; Sun, 18 Nov 2001 06:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279233AbRKRLA5>; Sun, 18 Nov 2001 06:00:57 -0500
Received: from [213.96.124.18] ([213.96.124.18]:39146 "HELO dardhal")
	by vger.kernel.org with SMTP id <S279201AbRKRLAq>;
	Sun, 18 Nov 2001 06:00:46 -0500
Date: Sun, 18 Nov 2001 12:00:39 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: tmpfs?
Message-ID: <20011118120038.A1771@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <003a01c16fe5$088ae9c0$0200000a@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003a01c16fe5$088ae9c0$0200000a@home>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 18 November 2001, at 00:56:37 -0300,
Norberto Bensa wrote:

> Hello,
> 
> I've configured my kernel (2.4.13-ac8) to use tmpfs, but it seems that it
> only uses half my physical memory (64 of 128MB).
> 
tmpfs as any other filesystem has mount time options. Check:
http://www-106.ibm.com/developerworks/library/l-fs3.html

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

