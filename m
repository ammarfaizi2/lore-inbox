Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWBFOJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWBFOJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWBFOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:09:42 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:50317 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932114AbWBFOJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:09:42 -0500
Subject: Re: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
From: Arjan van de Ven <arjan@infradead.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139203471.4641.41.camel@localhost>
References: <20060202041543.GA6755@RAM>
	 <1139085087.3131.8.camel@laptopd505.fenrus.org>
	 <1139203471.4641.41.camel@localhost>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 15:09:33 +0100
Message-Id: <1139234973.3131.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Eventually we want to generate a tool that can report API changes across
> kernel releases and put it in some friendly(docbook) format.

the CRC's are only very lightly related to API though (or even ABI) so I
suspect this isn't too useful a thing to persue in the first place
(using CRC I mean, documenting real API changes I can see being useful)


