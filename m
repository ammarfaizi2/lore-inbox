Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVIMXkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVIMXkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVIMXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:40:13 -0400
Received: from sa3.bezeqint.net ([192.115.104.17]:58002 "EHLO sa3.bezeqint.net")
	by vger.kernel.org with ESMTP id S1751102AbVIMXkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:40:12 -0400
Date: Wed, 14 Sep 2005 02:56:09 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snd-via82xx-modem do not work from 2.6.12 kernel version
Message-ID: <20050913235609.GB9531@tecr>
Mail-Followup-To: Dmitrij Bogush <dmitrij.bogush@gmail.com>,
	linux-kernel@vger.kernel.org
References: <2ac89c70050913145926583918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac89c70050913145926583918@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01:59 Wed 14 Sep     , Dmitrij Bogush wrote:
> I try to get MC97 modem working with 2.6.14-rc1 and get "NO DIAL
> TONE". I think that something wrong with driver source, becouse if
> replace snd-via82xx-modem.c with 2.6.11 version and recompile modules
> all works fine..

Try with 2.6.13, this should be fixed.

Sasha.
