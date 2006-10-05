Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWJEQHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWJEQHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWJEQHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:07:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12723 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932165AbWJEQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:07:15 -0400
Subject: Re: sunifdef instead of unifdef
From: David Woodhouse <dwmw2@infradead.org>
To: Tony Finch <dot@dotat.at>
Cc: Dennis Heuer <dh@triple-media.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610051648200.28237@hermes-2.csi.cam.ac.uk>
References: <20061005150816.76ca18c2.dh@triple-media.com>
	 <1160059253.26064.69.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0610051648200.28237@hermes-2.csi.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 17:07:08 +0100
Message-Id: <1160064428.26064.107.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 17:05 +0100, Tony Finch wrote:
> >       #if defined(__KERNEL__ && ....
> 
> I don't think your syntax errors are my problem :-)

Heh, good point :)

-- 
dwmw2

