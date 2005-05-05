Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVEEPm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVEEPm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVEEPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:42:56 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:4171 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262093AbVEEPms convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:42:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TcV2RhU3dJ5b4lRjDG2Cdpzs7U06KT4rrzxUPUC1gk08IoAyAwHXqDYqWOTauIF40LAaeebhuQiVIvpI0JYRgUQf/PVusFmZN/6OccYu9djo433EFbmFSfEw/tL4eI4Hz+r6JBIoxmDxhBKLaQx43NmehnNFwIbwW9rgdfABHac=
Message-ID: <87ab37ab050505084254521f08@mail.gmail.com>
Date: Thu, 5 May 2005 23:42:46 +0800
From: kylin <fierykylin@gmail.com>
Reply-To: kylin <fierykylin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: telnet bug in fedora Core 4 test 2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was in the fedora Core 4 test 2
on the installation ,i forget to install the legency network
then  i realize that telnet is needed ,
so i seek the pakadge containing telnet and xinetd ,then install them.
but ,always ,in the setup
i cannot let telnetd be selected, 
when i try to start it  using telnetd....
then error evolves like this: 
telnetd:get peername:socket operation on non-socket

-- 
we who r about to die,salute u!
