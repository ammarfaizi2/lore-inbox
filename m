Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVH3UwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVH3UwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVH3UwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:52:00 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:13534 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932460AbVH3Uv7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:51:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ekqoFuqmq6msYP4eNhlXMGbZyzGxtOqQnqWcJBf6DbuugHJPINTynNn7TMPu/ftlVNbF1CrHJswmwVgLIHw/pe28oBDhNqQEU6R8L5hTi4tIbr+aTOXd1UYM/EkpJsjfGe0XhI0vEJ8Jp0bxpWIJHJfgASk0kyfa1sCZt6CZNw4=
Message-ID: <6967c2bf0508301351584d6f10@mail.gmail.com>
Date: Tue, 30 Aug 2005 14:51:59 -0600
From: Pritesh Shah <pritesh.myphotos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: GDT initialization and location question.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was wondering as to where is the GDT initialized during the boot
sequence? I will need the filename and the name of the routine that
does this. Any help would be greatly appreciated.
Thanks in advance,
Pritesh
