Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269508AbRHCRWw>; Fri, 3 Aug 2001 13:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269495AbRHCRWc>; Fri, 3 Aug 2001 13:22:32 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:43789 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269531AbRHCRWV>;
	Fri, 3 Aug 2001 13:22:21 -0400
Message-Id: <200108022222.CAA00348@mops.inr.ac.ru>
Subject: Re: Leak in network memory?
To: wms@igoweb.ORG (William M. Shubert)
Date: Fri, 3 Aug 2001 02:22:02 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B64D418.3000608@igoweb.org> from "William M. Shubert" at Jul 30, 1 07:45:01 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> buffers of sockets. All sockets are set to have 64KB (the default) 

Are you sure? Default is 16K.

Alexey
