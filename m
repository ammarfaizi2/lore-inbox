Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVHQG5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVHQG5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVHQG5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:57:09 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:53689 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbVHQG5I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:57:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=itGaVGoqn5mcNNir3nAnb6q+mJmkYfKsxaIBolxdLgVNCB5RmpMxxLjVqt8zTW7mu6Y384AIM9Glhhymg0Q4wb8hSCFvxW0z/VB/dTk0KbeiTz9PohD5lOiJ/ncXHx4I4p/mGtUCWjRHfFbMODANbSDEY8Rz3DdzOBIZi+5dH4Y=
Message-ID: <17db6d3a050816235729eff2c0@mail.gmail.com>
Date: Wed, 17 Aug 2005 12:27:06 +0530
From: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: insmod error: Invalid module format.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
     I have RH9 installed with  2.6.7-1 kernel. I am able to compile
the module but , when i load this module using insmod i get an error
"insmod: error inserting './simple.o': -1 Invalid module format"

Please, any one tell me what is this meant ?

-- 
Thanks and Regards,
         Nikhil.
