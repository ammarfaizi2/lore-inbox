Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUJWUHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUJWUHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUJWUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:06:52 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:57658 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261295AbUJWUFu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:05:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ned5evtHdts3balJchljF7qh8uHWB374q3oXnYRBL7Si3hU1ziRLQyuOQnPktRa6bhZtwsUseSaiIarLFQk3A9KVGVzOP3LZr/vBIVAWLdg/LgCuqHD9WaNi2iIeet2JvZupQcVM1YU/DFzJ2SQQSG/HcU/Jxou78JXa4BjPs7E=
Message-ID: <7aaed09104102313057ca8e395@mail.gmail.com>
Date: Sat, 23 Oct 2004 22:05:45 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: kronos@kronoz.cjb.net
Subject: Re: My thoughts on the "new development model"
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20041023195811.GA11735@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20041023014004.GG22558@stusta.de>
	 <20041023195811.GA11735@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 21:58:11 +0200, Kronos <kronos@kronoz.cjb.net> wrote:
> Suppose that Linus or Andrew starts a new tree to develop some new and
> and very big and intrusive feature. Once it's done the tree will be
> merged back with 2.6 (should be easy with bk) or will become 2.8?
> Just Curious.
> 
> Luca

Well, if such changes are going into 2.6, it's just as good to put
them into Andrews -mm tree, imho.


-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
