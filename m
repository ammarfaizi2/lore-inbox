Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWFYJRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWFYJRV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWFYJRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:17:21 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:5227 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932146AbWFYJRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VNg6bUy6gaKRhqpxIkEtYv85gcjKvdkGS7XrpMdqtrWoJd+32JJQ/uOl+db1pXBBYV0G8L8OjXj6lHqlVT0JzP8Dw8ApOysmOhjd3riqsbg3EznIB8P8XINjWQZHcpTJorVdqi0EC9nyYO1jDvZ4+5yUc4fRAPeCEE5MWkxxkzI=
Message-ID: <8bf247760606250217m27c393famcae4cc252da46f17@mail.gmail.com>
Date: Sun, 25 Jun 2006 14:47:19 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 when i try to unload a wlan driver i get  the message:

 Badness in remove_proc_entry at fs/proc/generic.c:705


  This comes from the statment in the driver:
wlan_proc_remove("wlan");


  How does one solve the problem.


  This wlan driver was in 2.4. i ported it to 2.6. Is there any
difference as far as wlan/networking unregistering is concerned for a
wlan driver.


  Any pointers?
 Please Advice.

Regards,
sriram
