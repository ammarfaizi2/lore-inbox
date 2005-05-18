Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVERKMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVERKMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVERKMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:12:36 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:46724 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S262151AbVERKMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:12:34 -0400
Message-ID: <001b01c55b92$1d09c6e0$0101010a@dioxide>
From: "linux" <kernel@wired-net.gr>
To: "lkml" <linux-kernel@vger.kernel.org>
References: <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org> <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
Subject: 2.6 jiffies
Date: Wed, 18 May 2005 13:12:33 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why jiffies start counting from a negative number and after 5minutes the
counter gets positive????

