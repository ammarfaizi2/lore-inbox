Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWEOKg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEOKg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEOKg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:36:26 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:26586 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S964873AbWEOKgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:36:25 -0400
From: Oliver Neukum <oliver@neukum.name>
To: jayakumar.video@gmail.com
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v2
Date: Mon, 15 May 2006 12:36:14 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200605150849.k4F8nXDb031881@localhost.localdomain>
In-Reply-To: <200605150849.k4F8nXDb031881@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151236.14478.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Mai 2006 10:49 schrieb jayakumar.video@gmail.com:
> +static void qcm_setup_input_int(struct qcm *cam, struct uvd *uvd)
> +{

This should report errors.

	Regards
		Oliver
