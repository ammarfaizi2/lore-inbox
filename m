Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVBNWqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVBNWqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVBNWqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:46:13 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:21890 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261393AbVBNWqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:46:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Date: Mon, 14 Feb 2005 17:46:02 -0500
User-Agent: KMail/1.7.2
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
References: <41F11C66.5000707@sgi.com> <41F13924.50602@sgi.com> <4210D29E.9000808@sgi.com>
In-Reply-To: <4210D29E.9000808@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141746.03133.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2005 11:32, Prarit Bhargava wrote:
> I didn't see a final ACK on this patch -- just checking for one :)
> 
> P.

I see that resource allocation part is in Vojtech's tree now but the
part changing timeout message was dropped.

-- 
Dmitry
