Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281501AbRKMLNN>; Tue, 13 Nov 2001 06:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKMLND>; Tue, 13 Nov 2001 06:13:03 -0500
Received: from maile.telia.com ([194.22.190.16]:62411 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S281501AbRKMLMw>;
	Tue, 13 Nov 2001 06:12:52 -0500
Date: Tue, 13 Nov 2001 12:19:07 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio problems
Message-ID: <20011113121907.A9058@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011112220630.A1200@bruder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011112220630.A1200@bruder.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sergio@bruder.net <sergio@bruder.net> wrote:

> With rapid fast-forward in mplayer, The sound just mutes itself and
> mplayer just crawls down to 1-2 frames per second. Looking at
> /var/log/messages Ive got:

Try the latest 2.4.15-preX kernel since that has a much newer VIA audio
driver which might fix this.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
