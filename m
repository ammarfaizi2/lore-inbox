Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTDILuy (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTDILuy (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:50:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26267
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263012AbTDILuw (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:50:52 -0400
Subject: Re: kernel support for non-english user messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: oliver@neukum.name
Cc: fdavis@si.rr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304090729.08738.oliver@neukum.org>
References: <3E93A958.80107@si.rr.com>
	 <200304090729.08738.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049886246.9901.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 12:04:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 06:29, Oliver Neukum wrote:
> These messages are for administrators and developers. Everybody needs
> to be able to read them. They have to be in English.

Everyone cannot read English. Many non English speakers will be admins
of their own desktop boxes.

For the general case I agree. It would be nice to have message
catalogues and translation capability within klogd and maybe of
a few key messages to console but for most cases it would make things
more complex not simpler

