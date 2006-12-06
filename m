Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760343AbWLFJDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760343AbWLFJDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760341AbWLFJDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:03:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:49836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760343AbWLFJDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:03:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OguVAV+MU/wQW320o7ThxK0yytnSPBboyQGjDdJ0/X896ERaJrVqX2fXwFiHsaJr2CeGR2PPrboGAobiOEf/i49g5JcZjriJBI42jbK8l48mlCff1XlpQXvnGmSp5h/H7KjoM049j1rUMLhTqRlaGocnRd4LYuAE61K5lrZfFsM=
Message-ID: <6e0cfd1d0612060103g2d6f429i54525c8d323be11f@mail.gmail.com>
Date: Wed, 6 Dec 2006 10:03:09 +0100
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a device to a new parent.
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "Cornelia Huck" <cornelia.huck@de.ibm.com>,
       "Greg Kroah-Hartman" <gregkh@suse.de>
In-Reply-To: <1165332371.2756.23.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11650154123942-git-send-email-greg@kroah.com>
	 <11650154221716-git-send-email-greg@kroah.com>
	 <11650154251022-git-send-email-greg@kroah.com>
	 <11650154282911-git-send-email-greg@kroah.com>
	 <11650154311175-git-send-email-greg@kroah.com>
	 <1165163163.19590.62.camel@localhost>
	 <20061204195859.GB29637@kroah.com>
	 <1165266903.12640.35.camel@localhost>
	 <20061204230511.GA9382@kroah.com> <1165332371.2756.23.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> And btw. I can't see any s390 patches that are using device_move() at
> the moment.

These patches are in the git390 tree right now and will get push with
the next update.
Cornelia won't be available for a few weeks by the way (vacation).

-- 
blue skies,
  Martin
