Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSJAItR>; Tue, 1 Oct 2002 04:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJAItR>; Tue, 1 Oct 2002 04:49:17 -0400
Received: from achilles.noc.ntua.gr ([147.102.222.210]:60860 "EHLO ntua.gr")
	by vger.kernel.org with ESMTP id <S261554AbSJAItQ>;
	Tue, 1 Oct 2002 04:49:16 -0400
Message-ID: <3D996148.2020604@telecom.ntua.gr>
Date: Tue, 01 Oct 2002 11:48:08 +0300
From: Yannis Mitsos <gmitsos@telecom.ntua.gr>
Organization: National Technical Universit of Athens
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en, el
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Binary File format
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am investigating the potential to initiate a project to port a Linux 
kernel to a new processor.
This processor lacks of MMU so we have to adopt the uClinux approach.

Currently, the available tools can generate only COFF executable files.
What are the restrictions imposed by this ?? Can we initiate the project 
and wait a couple of months until the ELF tools are available ?

 From what I found until now it *seems* that we will not able to compile 
the 2.4.x kernel. Is this true ?
Are there any parts that cannot be compiled ? or the functionality of 
the tools will not be able to produce image ??

TIA

Yannis


