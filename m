Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWG0Iy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWG0Iy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWG0Iy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:54:26 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:31970 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932517AbWG0IyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:54:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pz9s07qAoPhESEpc8HrfVAPq4u8tLWECsEM380aaVwawYypjuFoGAUWpEz3YjYmlFJQFAO7dTo0pnCilQ8QJgNwavke2GWiW4OVznIfHXp58wPwvYvXOe0Xluu7BzDOsQyIENQrluC6aEbU5TOAcarBKrupaOmyLuodILSpMC80=
Message-ID: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com>
Date: Thu, 27 Jul 2006 10:54:23 +0200
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: The ondemand CPUFreq code -- I hope the functionality stays
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It sounds, from comments in the discussion of CPU Hotplug locking
problems, as though you are considering deleting the ondemand CPUFreq
code.  If this happens, I hope that something that provides the same
functionality replaces it.  I really appreciate having my power
consumption automatically modulated on an as needed basis.  Power
management seems to be one of the areas where there is a lot of room
for improvement.

Thanks,
      Miles
