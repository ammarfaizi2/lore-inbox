Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVF2KvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVF2KvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVF2KvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:51:13 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:11501 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262520AbVF2KvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:51:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sGXzAsOYp4A4VjwtiY4yxt/yDdL3ZiRkGIlX239R+W1ljLCuUJOVK2QJ0h8FaHxQ7N0EmMiVlKR3z6Dt55XCDSbnOveWUlapHR3QU7F54xlt2ZMSJbVahGHXl2Ez3axl3Xs3g9dye0F86u2BR5TXUvH48cQnb6ztAPvDWs8UXYg=
Message-ID: <ec2c5c2205062903511d62d6bf@mail.gmail.com>
Date: Wed, 29 Jun 2005 13:51:06 +0300
From: Ville Sundell <ville.sundell@gmail.com>
Reply-To: Ville Sundell <ville.sundell@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Build-in XML support?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I know, this maybe is F.A.Q, but I ask it anyway (because I have not found it
in kernel mail-list, so don't shot me!)  :

How about build-in XML-support to kernel?

Good or bad?

It would be wery useful for config-files? 
Yes, XML-format is big, an need disk space (that tag system needs
space), but it is easy to understand and it is standard way to format
data.

(...and I have a draft for small XML-parser in C-language;) )

-Ville Sundell
