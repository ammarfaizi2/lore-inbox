Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWHKWKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWHKWKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHKWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:10:30 -0400
Received: from ozlabs.org ([203.10.76.45]:62852 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932448AbWHKWK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:10:29 -0400
Date: Sat, 12 Aug 2006 08:07:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
Message-ID: <20060811220728.GI479@krispykreme>
References: <44D99F56.7010201@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99F56.7010201@de.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 

> +extern void exit(int);

Should be able to remove that prototype :) 

Anton
