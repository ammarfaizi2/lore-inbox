Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313753AbSDHVSc>; Mon, 8 Apr 2002 17:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313754AbSDHVSb>; Mon, 8 Apr 2002 17:18:31 -0400
Received: from mailout.zma.compaq.com ([161.114.64.104]:24846 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S313753AbSDHVSb> convert rfc822-to-8bit; Mon, 8 Apr 2002 17:18:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: system call for finding the number of cpus??
Date: Mon, 8 Apr 2002 17:18:30 -0400
Message-ID: <6B003D25ADBDE347B5542AFE6A55B42E01A4451A@tayexc13.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: system call for finding the number of cpus??
Thread-Index: AcHfQovsKqI04EgaEdar6wAIxysjbQ==
From: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2002 21:18:31.0313 (UTC) FILETIME=[EEF7B010:01C1DF42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
  I have a script that is using the /cpu/procinfo file to determine the number of cpus present in the system. But I would like to implement it using a system call rather than use the environment variables?? I couldn't find a system call for linux that would give me the result. Could anyone please let me know if there is one for redhat linux??

Thanks for your time,
Priya
