Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWEYVTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWEYVTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWEYVTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:19:35 -0400
Received: from n15a.bullet.sc5.yahoo.com ([66.163.187.158]:41852 "HELO
	n15a.bullet.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030428AbWEYVTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:19:34 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lima; d=yahoogroups.com;
	b=EmdJuHeMDY3Y8bGL5edVVJa4OA5tjpK96t9yAugwTx+W6W+oLvGBLpo6i5/NWmSI/wYvPCoxkhN9zaEFFBZqfsq/y4TPXE2kcRmXk7xMyqEPwTFzw5AubjphhO3WxfwD;
Date: Thu, 25 May 2006 21:19:33 -0000
From: "devmazumdar" <dev@opensound.com>
To: linux-kernel@vger.kernel.org
Subject: How to check if kernel sources are installed on a system?
Message-ID: <e55715+usls@eGroups.com>
User-Agent: eGroups-EW/0.82
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Yahoo Groups Message Poster
X-Yahoo-Post-IP: 66.229.53.8
X-Yahoo-Newman-Property: groups-compose
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does one check the existence of the kernel source RPM (or deb) on
every single distribution?.

We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
SuSE, Mandrake and CentOS - how about other RPM based distros? How
about debian based distros?. There doesn't seem to be a a single
conherent naming scheme. 

Another thing, can we please start enforcing that people ship kernel
source with the base installation? If distributors are distributing
kernels, then it must be an absolute requirement that they ship kernel
sources in a "configured" state as well.  If you're not going to
provide a stable kernel API, then atleast please make this a requirement. 


best regards

Dev Mazumdar
4Front Technologies
http://www.opensound.com















