Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWHPQcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWHPQcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWHPQct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:32:49 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:46735 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932100AbWHPQcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:32:48 -0400
Date: Wed, 16 Aug 2006 18:31:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove NULL check in register_nls()
In-Reply-To: <20060815184453.GA7482@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0608161831240.23266@yvahk01.tjqt.qr>
References: <20060815184453.GA7482@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Everybody passes valid pointer there.

Might want to document the function that @nls may not be %NULL.


Jan Engelhardt
-- 
