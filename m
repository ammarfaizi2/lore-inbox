Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbTFMW4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbTFMW4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:56:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18104
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265569AbTFMW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:56:05 -0400
Subject: Re: Geode MediaGX CD-ROM detection problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felipe Wilhelms Damasio <felipe@elipse.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rodrigo Gressler <rodrigo@elipse.com.br>
In-Reply-To: <D818C01D3A571F49AAB829274DAF9E0402D225@mars.elipse.com.br>
References: <D818C01D3A571F49AAB829274DAF9E0402D225@mars.elipse.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055545654.6592.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 00:07:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try booting with the option ide=nodma first of all

