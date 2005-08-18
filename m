Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVHRNEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVHRNEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVHRNEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:04:01 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:4882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932189AbVHRNEA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:04:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m2OiWEkcyCzWjgdmtM1aIe6QS8Z7m7k0IiiELLyIb0cnSraYUcpeB35BmQaaQ3S508wGF+x3oHRB/7CXbNYRQ6B/dfB0xR9cJGBKlosEtGo9kmvZJrobVrJPP5MhvpoHK0p93aptPH2ZeAoObJ8aGA9EA1WuxyiX4N8D2g3z9Vg=
Message-ID: <7cd5d4b405081806031b66ba45@mail.gmail.com>
Date: Thu, 18 Aug 2005 21:03:55 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: can I write to the cdrom through writing to the device file sr0?
In-Reply-To: <7cd5d4b4050818014042740322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b4050818014042740322@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank you!
such as cdrtools have the tools of mkiso9660 which can make an iso
file according to the iso9660 file system standard?but cdrecord can
only write an iso9660 file to the cdrom?


On 8/18/05, jeff shia <tshxiayu@gmail.com> wrote:
> I want to write a cdrw user space driver just like cdreord,but the
> cdrecord is too complex and huge!can I write to the cdrom through
> writing to the device file sr0,here sr0 is the device file of the
> cdrw.
>
