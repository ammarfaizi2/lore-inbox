Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWDZOLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWDZOLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWDZOLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:11:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40891 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932442AbWDZOLF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:11:05 -0400
Date: Wed, 26 Apr 2006 17:11:03 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "=?iso-8859-1?Q?J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>
cc: Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
In-Reply-To: <20060426110656.GD29108@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0604261710120.20454@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
 <1146038324.5956.0.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
 <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de>
 <1146046118.7016.5.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
 <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Jörn Engel wrote:
> Still, if you could respin this with gcc 4.1 and post the numbers,
> Pekka, that would be quite interesting.

I can do that, certainly. I'll send them tomorrow.

				Pekka
