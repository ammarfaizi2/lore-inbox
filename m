Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932926AbWKLPNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWKLPNM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbWKLPNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:13:12 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:48556 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S932926AbWKLPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:13:11 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: [RFC PATCH] RFkill - Add support for input key to control wireless radio
Date: Sun, 12 Nov 2006 16:13:45 +0100
User-Agent: KMail/1.8
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org
References: <200611121548.56908.IvDoorn@gmail.com>
In-Reply-To: <200611121548.56908.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121613.46286.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. November 2006 15:48 schrieb Ivo van Doorn:
> If the input device has been opened, rfkill will send the signal to
> userspace and do nothing further. The user is in charge of controlling
> the radio.

As turning off the radio is relevant to safety eg. in aircraft, hospitals,
etc., potentially ignoring the button is questionable.

	Regards
		Oliver
