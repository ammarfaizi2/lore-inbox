Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVDFD17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVDFD17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 23:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVDFD17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 23:27:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:63365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262092AbVDFD16 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 23:27:58 -0400
Date: Tue, 5 Apr 2005 20:27:35 -0700
From: Greg KH <greg@kroah.com>
To: Derek Cheung <derek.cheung@sympatico.ca>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-ID: <20050406032735.GA23212@kroah.com>
References: <20050405044836.GA17336@kroah.com> <003801c53a4e$e5df3d80$1501a8c0@Mainframe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c53a4e$e5df3d80$1501a8c0@Mainframe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:18:15PM -0400, Derek Cheung wrote:
> Hi Greg and Andrew,

After you fix the diff issues that Randy pointed out, please be sure to
 CC: the sensors mailing list as found in the MAINTAINERS file.  I know
they will be able to give you feedback on the code.

thanks,

greg k-h
