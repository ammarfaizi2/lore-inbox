Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVAXSxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVAXSxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVAXSxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:53:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261565AbVAXSxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:53:07 -0500
Date: Mon, 24 Jan 2005 13:52:58 -0500
From: Dave Jones <davej@redhat.com>
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124185258.GB27570@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Brice.Goglin@ens-lyon.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F4E28A.3090305@ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:56:58PM +0100, Brice Goglin wrote:
 > X does not work anymore when using DRI on my Compaq Evo N600c (Radeon 
 > Mobility M6 LY).
 > My XFree 4.3 (from Debian testing) with DRI uses drm and radeon kernel 
 > modules.
 
My fault. I'm looking into it.
Drop the agpgart-bk update for now.

		Dave

