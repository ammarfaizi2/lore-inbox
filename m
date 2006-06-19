Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWFSBRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWFSBRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWFSBRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:17:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:30619 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932238AbWFSBRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:17:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSeDkrt8XyVCtPsLEGPm3ckw5zXWDW8S5k+/Zuu2vX0BkbtE6ERiutXuIoKirdkreJM23WJ4Js8VNVFsAegJtjcji7EzfkJtVi1LaBKfJiCVLKbagBWLXWa4yMfOKFcaQR3IGJ3jcKfxujT2cTso+cnJPrHHrDVpnOX46R1uryk=
Message-ID: <bda6d13a0606181817q2ab4e5cev670ef5c537b63e6c@mail.gmail.com>
Date: Sun, 18 Jun 2006 18:17:22 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
In-Reply-To: <4495F5C3.1030203@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060618221343.GA20277@kroah.com>
	 <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
	 <4495F5C3.1030203@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With udev, you could mknod it yourself (in your application), then open it.
That would fire up the auto-module-load.
