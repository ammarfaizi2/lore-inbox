Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131701AbRCTDWi>; Mon, 19 Mar 2001 22:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131704AbRCTDW1>; Mon, 19 Mar 2001 22:22:27 -0500
Received: from postal.ic.sunysb.edu ([129.49.1.24]:50632 "EHLO
	mail.ic.sunysb.edu") by vger.kernel.org with ESMTP
	id <S131701AbRCTDWO>; Mon, 19 Mar 2001 22:22:14 -0500
Date: Mon, 19 Mar 2001 22:21:33 -0500 (EST)
From: Fu-hau Hsu <fhsu@ic.sunysb.edu>
To: linux-kernel@vger.kernel.org
cc: Fu-hau Hsu <fhsu@ic.sunysb.edu>
Subject: code region
Message-ID: <Pine.GSO.4.21.0103192209490.9311-100000@sparky.ic.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends:

 I have a question about memory protection. I appreciate any suggestion. 
 Thank you so much.

    Given a virtual address, how can we know whether this address contains
    an executable code? If there is a method that can be used to answer
    the above question, is there any exception for this method?

    PS:
    (a)Could we get the result by checking the VM_EXECUTABLE attribute of
    the vm_flags of the vm_area_struct for the memory area that contains    
    that address? If yes, does this apply to x86 architecture?

    (b) Could information in vm_page_prot of vm_area_struct or in
        struct mem_map_t help? If yes, which attribute and how?

  Best Regards,

FuHau               

