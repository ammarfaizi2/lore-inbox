Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264927AbUD2TKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUD2TKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUD2TKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:10:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17843 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264927AbUD2TK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:10:27 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Bryan Small <code_smith@comcast.net>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: add new USB PhidgetServo driver
Date: Thu, 29 Apr 2004 21:10:21 +0200
User-Agent: KMail/1.5.1
Cc: Sean Young <sean@mess.org>, Chester <fitchett@phidgets.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040428181806.GA36322@atlantis.8hz.com> <20040429031040.GA5336@kroah.com> <EF9BE23E-9A0D-11D8-B72E-000A95B17CC2@comcast.net>
In-Reply-To: <EF9BE23E-9A0D-11D8-B72E-000A95B17CC2@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292110.21235.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. April 2004 20:49 schrieb Bryan Small:
> The IFkit ( both 8/8/8 and 0/8/8) and the TextLCD will work nearly the
> same as Sean's servo control. They will use sysfs also. They will be

I don't want to spoil the party, but in which way is using sysfs in this
way different from using it as a form of devfs?

	Regards
		Oliver

