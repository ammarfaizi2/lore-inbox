Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281146AbRKTQCF>; Tue, 20 Nov 2001 11:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281147AbRKTQB4>; Tue, 20 Nov 2001 11:01:56 -0500
Received: from mout1.freenet.de ([194.97.50.132]:19364 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S281146AbRKTQBn>;
	Tue, 20 Nov 2001 11:01:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Wolfgang Rohdewald <wr6@uni.de>
Reply-To: wr6@uni.de
To: "J.A. Magallon" <jamagallon@able.es>, James A Sutherland <jas88@cam.ac.uk>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 17:01:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <200111191051.LAA04099@zhadum.sara.nl> <E165oY1-0006Db-00@mauve.csi.cam.ac.uk> <20011120155143.A4597@werewolf.able.es>
In-Reply-To: <20011120155143.A4597@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011120160131.87644332@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> When a page is deleted for one executable (because we can re-read it from
> on-disk binary), it is discarded, not paged out.

What happens if the on-disk binary has changed since loading the program?
