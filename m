Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTB0InP>; Thu, 27 Feb 2003 03:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTB0InP>; Thu, 27 Feb 2003 03:43:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:12815 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262038AbTB0InM>; Thu, 27 Feb 2003 03:43:12 -0500
Date: Thu, 27 Feb 2003 08:53:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: jh@sgi.com, barnes@sgi.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227085329.A27797@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, jh@sgi.com,
	barnes@sgi.com, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 27, 2003 at 03:14:44AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <jh@sgi.com[helgaas]>:
>   o ia64: Update SGI SN files

This one adds a strtok_r implementation instead of just using strsep,
strange, strange..
