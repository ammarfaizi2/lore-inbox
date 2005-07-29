Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVG2Q2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVG2Q2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVG2Q0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:26:44 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:59574 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262664AbVG2QZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:25:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eUYc80Olec8Rp/IZHS9oQVrlhPGNaEc1/4u3WhAn3gUt5IkNhSjorTmZ591AtuiDfWm38nclqbsWFuEgQg9cHU0W0R+uYuBydnlFsFPMavGym6XUEq6VDOjfViKPIztMiig+/MXx2HulQ6dty1wl7C2E4v+Zxi16zLS4kjQFD+c=
Message-ID: <5a67a16f05072909245ae1c44c@mail.gmail.com>
Date: Fri, 29 Jul 2005 12:24:49 -0400
From: Athul Acharya <aacharya@gmail.com>
Reply-To: Athul Acharya <aacharya@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Determining if the current processor is Hyperthreaded
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Is there a quick way to determine if the current processor is
Hyperthreaded, and if so, which logical processor represents the other
thread on the chip? Please cc replies to me as I am not subscribed to
the list :-)

Thanks,

Athul
