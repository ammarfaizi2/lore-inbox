Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754278AbWLEXp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbWLEXp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755519AbWLEXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:45:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:55028 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbWLEXp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:45:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZYrrji3XL9nlL+YVy5WHjPQvFsBfEpzxWP8qzr0VJs/ozJZcZU0APWbY94wPKHMXzUc+L9mH+gsf9ZzT7ljRBREkPYZUD0WHoJvqfRDWA0S/Px+lopMJjn4Z7dHYLGv8hF2BRo48nr3GsGxmzq4OrrA9y4LSv6PZrkz0Fhp3p6w=
Message-ID: <b3234d300612051545s7d765eaar3c07d30fd6e0462@mail.gmail.com>
Date: Tue, 5 Dec 2006 17:45:57 -0600
From: "JAK anon" <jakk127@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: xtables/iptables and atkbd.c Spurious ACK on isa0060/serio0
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have posted this on a few forums,and some people suggested that
I post it here to see if I could get any help. I recently complied a
2.6.19 kernel. I realized that I needed to compile in support for
iptables,so I put in xtables and iptables. However,when I booted up
the kernel,I got the repeating message "atkbd.c Spurious ACK on
isa0060/serio0" and the system hung. This can be fixed if I take out
xtables support. I was wondering if anyone knew why xtables was
causing this,I don't want to go online without having iptables. Thanks
for your help.
