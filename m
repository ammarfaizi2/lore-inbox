Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSKOR1S>; Fri, 15 Nov 2002 12:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSKOR1S>; Fri, 15 Nov 2002 12:27:18 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:26799 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266560AbSKOR1Q>; Fri, 15 Nov 2002 12:27:16 -0500
Subject: Re: Status of the CMD680 IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <73fe.3dd52324.188a7@gzp1.gzp.hu>
References: <73fe.3dd52324.188a7@gzp1.gzp.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 18:00:37 +0000
Message-Id: <1037383237.19971.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 16:39, Gabor Z. Papp wrote:
> Seems like it is in the later 2.4, but removed from the -ac
> line, and missing from the 2.5 tree.

siimage driver drives the CMD680 and the SATA SII3112 version of the
chip.

