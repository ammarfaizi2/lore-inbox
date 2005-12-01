Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVLAMxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVLAMxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLAMxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:53:53 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:3244 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932198AbVLAMxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:53:52 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: More 2.6.15-rc3 problems
Date: Thu, 1 Dec 2005 14:53:09 +0200
User-Agent: KMail/1.8.92
References: <200512010419.48394.ismail@uludag.org.tr> <20051201095425.GB29416@gemtek.lt>
In-Reply-To: <20051201095425.GB29416@gemtek.lt>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512011453.10022.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thursday 01 December 2005 11:54 tarihinde, Zilvinas Valinskas şunları 
yazmıştı: 
> Fix is already in rc4 - please try this version.
>
> On Thu, Dec 01, 2005 at 04:19:47AM +0200, Ismail Donmez wrote:
> > Hi,
> >
> > Looks like gdb doesn't work with 2.6.15-rc3 kernel. Trying to run ls or
> > any other binary crashes gdb and ooopses kernel. Here is the log :

Thanks, looks fixed.

Regards,
ismail
