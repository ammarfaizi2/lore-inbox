Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVALCAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVALCAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVALCAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:00:55 -0500
Received: from mail.aei.ca ([206.123.6.14]:6852 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263000AbVALCAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:00:45 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.10-ck3
Date: Tue, 11 Jan 2005 22:03:29 -0500
User-Agent: KMail/1.7.1
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
References: <41E45F8D.2050204@kolivas.org>
In-Reply-To: <41E45F8D.2050204@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112203.29532.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 January 2005 18:21, Con Kolivas wrote:
> http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck3/

Con,

With cfq adding fair share writing, is the vm-pageout-throttling patch still needed?  Suspect
that cfq might just handle it...

Ed Tomlinson
