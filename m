Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbSJXLjE>; Thu, 24 Oct 2002 07:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSJXLjE>; Thu, 24 Oct 2002 07:39:04 -0400
Received: from [195.20.32.236] ([195.20.32.236]:46785 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S265408AbSJXLjD>;
	Thu, 24 Oct 2002 07:39:03 -0400
Date: Thu, 24 Oct 2002 13:45:04 +0200
From: Alexander Kellett <lypanov@kde.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.42
Message-ID: <20021024114504.GA18130@groucho.verza.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0210131545510.17395-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.44L.0210131755340.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210131755340.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 05:57:06PM -0200, Rik van Riel wrote:
> All you need is:
> 1) a kernel level driver that can map devices, ie. a device mapper
> 2) user space tools that can parse the volume metadata and tell the
>    kernel how to map each chunk at initialisation or mount time

stupid user question here. does the dm stuff make
vmware partition mounts easy without needing
all the nbd overhead?, or would the mappings be
so large that they negate the decrease in nbd
overhead?

Alex
