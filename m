Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVEXPPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVEXPPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVEXPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:15:30 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:38359 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261266AbVEXPPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:15:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Olnhq1XQG/dx+Wd7p1JcbzXX5DKcCFiXEzHhxEkDe9qKqW3jk4ffeof/QHxdhM3N1bO24nDizlpKbrBekHIT0s2MDW0qnm4QuFr9Q5OVPsn0RI0U4LWqPp+p0ioOvUgSOY1nV725oF6116IUIHXr85cjr7taVRi7KETSaHq/p3A=
Message-ID: <187e0cd605052408154bef1566@mail.gmail.com>
Date: Tue, 24 May 2005 17:15:23 +0200
From: "Aurelien B." <kerusursaone@gmail.com>
Reply-To: "Aurelien B." <kerusursaone@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE: ide-scsi problems
In-Reply-To: <187e0cd605052407383eb425b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <187e0cd605052407383eb425b1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Aurelien B. <kerusursaone@gmail.com>
Date: 24 mai 2005 16:38
Subject: ide-scsi problems
To: linux-ide@vger.kernel.org


Hello,
maybe im on the wrong, i dont really know if i can find help here.
i compiled the 2.6.12-rc4, everything works fine, and i tried ide-scsi
module to get better dvd burning speed.
it works, i get 5x transfer, but once its finished, the dvd burner is
no longer recognized and doesnt want to eject, i have to reboot to get
it work again.
without ide-scsi, i only have a 1x burning speed and the dvd can eject
and burn another one without pb.
