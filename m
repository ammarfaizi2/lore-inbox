Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWGMUcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWGMUcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWGMUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:32:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:43786 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030362AbWGMUci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:32:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WVmBMntoaiHF6EqCEJdl9EsGsOnFfrHe2SNrD7aceOB3x3gutOUeBNwOnrDPK21d0AnP8/BpHDuHBWBXTBoVsVmasRYo1L3abhDvQjD2s21YxlVk/ybzHz9PsCw0I+NP9Qgwg4AJG8qopv+JAD4llB23JbYtLs12Q0Dcwn4B1yg=
Message-ID: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
Date: Thu, 13 Jul 2006 22:32:38 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm not quite sure where the right place is to go with this, so now
I'm asking here.  Hope you can help.

I have a ~1TB filesystem that failed to mount today, the message is:

EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
group 2338 not in group (block 1607003381)!
EXT3-fs: group descriptors corrupted !

Yesterday it worked flawlessly.

What's the problem, and what's the best course of action?

(cc appreciated, as I'm not subscribed!)
