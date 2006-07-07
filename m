Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWGGXvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWGGXvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGGXvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:51:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:26521 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751243AbWGGXvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:51:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DDELOh2HkOu2dLD2EgJ3bp8C/UeG3IUVfWQf371DncU0fxMrI3ifYvAifH6GujyXYbrv4QsVQRflEE/egmFANBvw8PNOZxrYWRFlKwzKbKN6qej1AjjOpfqOObgcrRcUDnDpIYTuTN1cIW1ISoZiAuwF+1JJWZIWSEMfy5Fx5OA=
Message-ID: <2625b9520607071651g2678bf40u7c9b353942f262f9@mail.gmail.com>
Date: Fri, 7 Jul 2006 16:51:06 -0700
From: "Thushara Wijeratna" <thushw@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pdflush taking CPU time during heavy NFS I/O
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/1173.html
describes a patch Anddrew Morton made to resolve this issue.
Did this make it into 2.6.9-* kernel? I have a 2.6.9-11 kernel that exhibits
similar symptoms.

Thanks,
Thushara
