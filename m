Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVFVRvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVFVRvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVFVRm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:42:58 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:49321 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261808AbVFVRjp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:39:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M6Kma9I7xd1QDBDk5H3zoTPOx7PDjhBpvYgZNwog680RYtHrc4mb8AxPAr6SEUNPUNU4G4QkQ2qmiN43etFLhNU/ZC33vh1zSW+3x2B/chdJDiyY7LZ1gPE6MgsOJwHO3liHr0Ss+4HPDRdo6dJM/lxZ/Pk2IzUnwRLtnGcPVGA=
Message-ID: <4ae3c1405062210393445b60@mail.gmail.com>
Date: Wed, 22 Jun 2005 13:39:44 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: about prefetch function used by list.h
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this question is dumb.

I use the link management functions  defined in list.h to setup my
links in user programs. but when I tried to migrate those programs to
Solaris on Sun workstations, I don't know how to define the function
prefetch, which is arch dependent.

Anyone know to do this? 

Thanks in advance!

-x
