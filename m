Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTE0Aoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTE0Aoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:44:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9420
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262413AbTE0Aoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:44:38 -0400
Subject: Re: [PATCH][2.5] static MAX_MP_BUSSES increase for Summit boxes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305232027.26945.jamesclv@us.ibm.com>
References: <200305232027.26945.jamesclv@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053993585.17129.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 00:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-24 at 04:27, James Cleverdon wrote:
> The dynamic MAX_MP_BUSSES fix for v2.4 never made it into 2.5.  x440s with 
> RXE100s and 32-way x445s without can easily overflow it.
> 
> Here's a static patch:

Port the proper fix surely

