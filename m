Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUDAL5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUDAL5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:57:15 -0500
Received: from tench.street-vision.com ([212.18.235.100]:56737 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262872AbUDAL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:57:14 -0500
Subject: Re: [PATCH] libata transport attributes
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       mort@wildopensource.com
In-Reply-To: <406B3313.3080607@pobox.com>
References: <1080752942.27347.43.camel@lotte.street-vision.com>
	 <406B3313.3080607@pobox.com>
Content-Type: text/plain
Message-Id: <1080820605.30218.14.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 12:56:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 22:07, Jeff Garzik wrote:

> Did you see the comments I posted WRT mort's patch?
> 

oops, no I missed his patch and your comments until now.

> Since libata is leaving SCSI in 2.7, I would rather not add superfluous 
> stuff like this at all.
> 

I didnt know this.

> Further, you can already retrieve the information you export with _zero_ 
> new code.

How? Sorry to be dumb...

Justin


