Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTFJVca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFJVcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:32:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50855
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262426AbTFJVcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:32:03 -0400
Subject: Re: Is there a maintainer for serverworks.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Washer <washer@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OFAC2B627A.47E6B5B2-ON88256D41.0069C908-88256D41.0069E577@us.ibm.com>
References: <OFAC2B627A.47E6B5B2-ON88256D41.0069C908-88256D41.0069E577@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055281381.32662.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 22:43:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-10 at 20:18, James Washer wrote:
> 
> 
> I see the 2.4.20 kernel ships with serverworks.c version 0.3, which
> is GPL'd,  RH9.0 ships with version 0.7 ( with no mention of GPL)
> 
> Does anyone know the story on this?  Who authored 0.7? Is it GPL'd??

0.7 is based on 0.3. Its by Michel Aubry, Andrzey, Sun and Red Hat. Not
sure where the usual 4 line GPL blurb went. 2.4.21rc has 0.8 btw.

Alan

