Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWHGKjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWHGKjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 06:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWHGKjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 06:39:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63108 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751138AbWHGKjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 06:39:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o4o+SM0NYrbrz2pCnxmgYfPTBLTdlYPg6AZqKLQiX/4edJ78YN1baCz8K1Lv3sA8ZYKdS2f45+e3LAyCmsi994wPIlmhE83UeYXCsMfrzqYCeruedNk1CGWzE+itCQJ/46ZJPgWBZoD2nYoe9xSC7fyfJV7cAd7RPyH8VwK5RgM=
Message-ID: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
Date: Mon, 7 Aug 2006 16:09:02 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: "Linux Newbie" <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Univeral Protocol Driver (using UNDI) in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I was curious as to why a Universal driver (using UNDI API) for Linux
does not exist (or does it)?

I want to try and write a such a driver that could (in principle)
handle all the NICs that are PXE compatible.

Has this been tried? What are the technical problems that might come in my way?

Thanks,

Dan
